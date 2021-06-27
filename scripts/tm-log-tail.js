const child_process = require('child_process');

(function() {
    let lastKnownLine = undefined;
    function log() {
        const out = child_process.execSync(`printf '\e[3J' && log show --predicate 'subsystem == "com.apple.TimeMachine"' --info --last 5m | grep -F 'eMac' | grep -Fv 'etat' | awk -F']' '{print substr($0,1,19), $NF}'`, {
            encoding: 'utf8'
        });

        const lines = out.split('\n');
        let iN = lines.length - 1;
        const newLines = [];
        while (iN > 0 && lines[iN] !== lastKnownLine) {
            newLines.unshift(lines[iN]);
            iN -= 1;
        }
        if (newLines.length) {
            newLines.forEach(l => {
                if (!l.trim()) {
                    return;
                }
                console.log(l.trim());
                lastKnownLine = l;
            });
        }
        setTimeout(log, 5000);
    }
    
    log();
})();
