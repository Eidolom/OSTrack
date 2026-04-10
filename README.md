# OSTrack

Flutter application for OSTrack product prototyping and roadmap delivery.

## Backend Runtime Config

Backend credentials are injected with `--dart-define` and are not stored in source files.

Required defines:

- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `TYPESENSE_HOST`
- `TYPESENSE_SEARCH_API_KEY` (search-only key, never an admin key)

Optional defines:

- `TYPESENSE_PORT` (default `8108`)
- `TYPESENSE_PROTOCOL` (default `https`)
- `TYPESENSE_CONNECTION_TIMEOUT_MS` (default `8000`)
- `ORIGINALS_R2_BASE_URL` (base URL for OSTrack Originals audio in Cloudflare R2)

Example run command:

```powershell
flutter run `
	--dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co `
	--dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY `
	--dart-define=TYPESENSE_HOST=YOUR_TYPESENSE_HOST `
	--dart-define=TYPESENSE_SEARCH_API_KEY=YOUR_SEARCH_ONLY_KEY `
	--dart-define=ORIGINALS_R2_BASE_URL=https://YOUR_BUCKET.r2.dev/originals
```

Security notes:

- Do not commit real keys to Git.
- Only use a Typesense search-only key in client builds.
- Keep production keys in CI secrets or local untracked launch configs.
