# Demo scenarios
1. CodeQL:   git checkout -b demo/sqli && cp demo/vulnerable_code.py app/vulnerable.py && commit, push, open PR
2. Dependency review: git checkout -b demo/deps && cp demo/vulnerable_requirements.txt requirements.txt && commit, push, open PR
3. Secret push protection: put a real-format credential in a file and push (see main README notes)
4. Ruleset: git push origin main directly (should be rejected)
5. Provenance: gh attestation verify oci://ghcr.io/OWNER/REPO@sha256:DIGEST --owner OWNER
