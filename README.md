# perl

Perl utility scripts for **bulk hardware lookups from Dell service tags**.

Each `getserial*.pl` script reads a list of Dell service tags (one per line)
from an input file, scrapes Dell's support site for each tag (using `LWP` +
`Mojo::DOM`, with cookie handling and a spoofed browser user-agent), and writes
the results to `<inputfile>.out`.

> Archival / personal tooling. Because it scrapes an external site, the scripts
> may need updating if Dell's support pages change.

## Scripts

| Script | Notes |
|--------|-------|
| `getserial.pl`  | Base version. |
| `getserial2.pl` | Variant (refined parsing/fields). |
| `getserial3.pl` | Variant (refined parsing/fields). |

## Usage

```bash
# tags.txt: one Dell service tag per line
perl getserial.pl tags.txt
# results written to tags.txt.out
```

### Requirements

- Perl 5
- CPAN modules: `LWP::Simple`, `LWP::UserAgent`, `HTTP::Cookies`, `Mojo::DOM`

```bash
cpan LWP::UserAgent Mojolicious
```
