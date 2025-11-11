#!/usr/bin/env python3

"""The script generates a SBOM matrix for all managed projects."""

import argparse
import logging
from typing import List
import requests
import yaml

logger = logging.getLogger("generate-sbom-matrix")
logging.basicConfig(level=logging.INFO)

PROJECTS: List[dict] = [
    {"name": "advanced-routing", "type": "charm"},
    {"name": "hardware-observer", "type": "charm"},
    {"name": "juju-backup-all", "type": "charm"},
    {"name": "local-users", "type": "charm"},
    {"name": "userdir-ldap", "type": "charm"},
    {"name": "openstack-exporter", "type": "charm"},
    {"name": "juju-backup-all", "type": "snap"},
    {"name": "prometheus-juju-backup-all-exporter", "type": "snap"},
    {"name": "tempest", "type": "snap"},
    {"name": "charmed-openstack-upgrader", "type": "snap"},
    {"name": "charmed-openstack-exporter", "type": "snap"},
    {"name": "smartctl-exporter", "type": "snap"},
    {"name": "dcgm", "type": "snap"},
    {"name": "tailscale", "type": "snap"},
    {"name": "headscale", "type": "snap"},
    {
        "name": "derper",
        "type": "snap",
        "risk": "edge",  # override risk for derper snap, only available on edge
    },
]

SBOM_MATRIX: dict = {
    "clients": {
        "sbom": {
            "department": "managed_services",
            "email": "eric.chen@canonical.com",
            "team": "solutions_engineering",
        },
        "secscan": {},
    },
    "artifacts": [],
}

SNAP_API_URL = "https://api.snapcraft.io/v2/snaps/info/{snap_name}"
SNAP_API_HEADERS = {
    "Accept": "application/json",
    "Snap-Device-Series": "16",
    "User-Agent": "Canonical-Solutions-Engineering/1.0",
}

CHARM_API_URL = "https://api.charmhub.io/v2/charms/info/{charm_name}?fields=channel-map,default-release.channel.track"

OUTPUT_FILE = "sbom_manifest.yaml"
DEFAULT_ARCHITECTURE = "amd64"
DEFAULT_RISK = "stable"


def handle_snap(name: str, risk: str, cycle: str, arch: str) -> dict:
    """Handle snap project SBOM retrieval."""
    resp = requests.get(SNAP_API_URL.format(snap_name=name), headers=SNAP_API_HEADERS)
    resp.raise_for_status()

    snap_info = resp.json()
    snap_default_track = snap_info.get("default-track") or "latest"
    channels = snap_info.get("channel-map", [])
    revision = None

    for ch in channels:
        ch_info = ch.get("channel", {})
        if (
            ch_info.get("track") == snap_default_track
            and ch_info.get("risk") == risk
            and ch_info.get("architecture") == arch
        ):
            revision = ch.get("revision")
            break

    if not revision:
        raise ValueError(
            f"Revision not found for snap {name} on risk {risk} and arch {arch}"
        )

    return {
        "name": name,
        "type": "snap",
        "version": str(revision),
        "ssdlc_params": {
            "name": name,
            "version": str(revision),
            "channel": risk,
            "cycle": cycle,
        },
    }


def handle_charm(name: str, risk: str, cycle: str, arch: str) -> dict:
    """Handle charm project SBOM retrieval."""
    resp = requests.get(CHARM_API_URL.format(charm_name=name))
    resp.raise_for_status()

    charm_info = resp.json()
    charm_default_track = (
        charm_info.get("default-release", {}).get("channel", {}).get("track")
        or "latest"
    )
    channels = charm_info.get("channel-map", [])

    filtered_channels = [
        ch
        for ch in channels
        if ch.get("channel", {}).get("base", {}).get("architecture") == arch
        and ch.get("channel", {}).get("track") == charm_default_track
        and ch.get("channel", {}).get("risk") == risk
    ]

    if not filtered_channels:
        raise ValueError(
            f"No channels found for charm {name} with arch {arch} and track {charm_default_track}"
        )

    highest_base_channel = max(
        filtered_channels,
        key=lambda ch: ch.get("channel", {}).get("base", {}).get("channel", "0"),
    )
    revision = highest_base_channel.get("revision", {}).get("revision")

    if not revision:
        raise ValueError(
            f"Revision not found for charm {name} on risk {risk} and arch {arch}"
        )

    return {
        "name": name,
        "type": "charm",
        "version": str(revision),
        "ssdlc_params": {
            "name": name,
            "version": str(revision),
            "channel": risk,
            "cycle": cycle,
        },
    }


def generate_matrix(risk: str, cycle: str, arch: str) -> dict:
    """Generate the SBOM matrix and print it."""
    artifacts = []

    for project in PROJECTS:
        pname = project["name"]
        ptype = project["type"]
        risk_override = project.get("risk") or risk
        arch_override = project.get("arch") or arch

        logger.info(
            f"Processing project - {ptype} {pname}, risk: {risk_override}, arch {arch_override}"
        )
        try:
            if ptype == "snap":
                artifact = handle_snap(pname, risk_override, cycle, arch_override)
            elif ptype == "charm":
                artifact = handle_charm(pname, risk_override, cycle, arch_override)
            else:
                logger.warning(f"Unknown project type '{ptype}' for project {pname}")
                continue
        except Exception as e:
            logger.error(f"Failed to process project {pname}: {e}, skipping.")
            continue

        artifacts.append(artifact)

    SBOM_MATRIX["artifacts"] = artifacts
    return SBOM_MATRIX


def main():
    """Run the script."""
    parser = argparse.ArgumentParser(
        prog="Generate SBOM Matrix",
        description="Generates a SBOM matrix for all managed projects.",
    )
    parser.add_argument("--cycle", required=True, help="The release cycle (e.g. 25.10)")
    parser.add_argument(
        "--risk",
        default=DEFAULT_RISK,
        help="The risk to create the SBOMs for (default: stable)",
    )
    parser.add_argument(
        "--arch",
        default=DEFAULT_ARCHITECTURE,
        help=f"The architecture to fetch the SBOMs for (default: {DEFAULT_ARCHITECTURE})",
    )
    parser.add_argument(
        "--output",
        default=OUTPUT_FILE,
        help=f"The output file to write the SBOM matrix to (default: {OUTPUT_FILE})",
    )

    args = parser.parse_args()
    matrix = generate_matrix(args.risk, args.cycle, args.arch)

    if not matrix.get("artifacts"):
        logger.error("No artifacts found, aborting.")
        exit(1)

    with open(args.output, "w") as f:
        yaml.safe_dump(matrix, f, sort_keys=False)

    logger.info(f"SBOM matrix written to {args.output}")


if __name__ == "__main__":
    main()
