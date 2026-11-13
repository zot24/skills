// `designmd lint` exits 0 on warnings, but a warning on the lock is a defect
// (site-design-options, docs/stitch-and-design-md.md#gates). Fail on errors and warnings.
import { execFileSync } from 'node:child_process';

let out;
try {
  out = execFileSync('designmd', ['lint', 'DESIGN.md'], { encoding: 'utf8' });
} catch (err) {
  out = err.stdout;
}
const report = JSON.parse(out);
for (const f of report.findings) if (f.severity !== 'info') console.error(`${f.severity}: ${f.rule}: ${f.message}`);
const { errors, warnings } = report.summary;
console.log(`DESIGN.md lint: ${errors} errors, ${warnings} warnings`);
process.exit(errors + warnings ? 1 : 0);
