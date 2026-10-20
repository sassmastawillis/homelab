# b2-backups

Provisions Backblaze B2 buckets for off-site restic backups (via Backrest), each with its own scoped application key.

- **One bucket per backup target**, defined in `var.buckets`. Adding a target is a one-line change.
- **One key per bucket**, limited to that bucket and to the capabilities restic needs (list, read, write, delete).
- **Private buckets** with SSE-B2 encryption at rest; restic also encrypts client-side.
- **Lifecycle rule** purges hidden file versions so restic prunes actually free space.

## Usage

Credentials come from the environment, never from code:

```bash
export B2_APPLICATION_KEY_ID=...
export B2_APPLICATION_KEY=...

terraform init
terraform plan
terraform apply

terraform output buckets          # Backrest repo URIs: b2:<name>
terraform output -json keys       # per-bucket key secrets (sensitive)
```

State holds the generated key secrets, so it stays local and is git-ignored.
