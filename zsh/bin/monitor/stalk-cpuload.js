#!/usr/bin/env node

// Based on http://www.linuxquestions.org/questions/linux-server-73/run-a-script-if-the-server-load-is-above-a-certain-value-853872/#post4211665

var exec = require('child_process').exec,
    fs = require('fs'),
    program = require('commander'),
    util = require('util'),
    divider = '-------------------------------';

program
  .option('-l, --log <file>')
  .option('-m, --min <#>', 'Minimum cpuload to trigger logging, ex. 0.5', Number)
  .option('-s, --sleep <#>', 'Seconds between checks', Number)
  .parse(process.argv);

if (!program.log || !program.min || !program.sleep) {
  console.err('See --help for usage.');
  process.exit(1);
}
var check = function(fd) {
  exec('uptime | cut -d " " -f 14 | cut -d "," -f 1', null, function(err, stdout, stderr) {
    if (err) { throw err; }

    var load = parseFloat(stdout.toString(), 10);

    if (load < program.min) {
      setTimeout(check.bind(null, fd), program.sleep * 1000);
      return;
    }

    exec('top -b -n 1 -c | head -n 32', null, function(err, stdout, stderr) {
      if (err) { throw err; }

      var event = util.format(
        '\n%s\n%s\nload: %d\n%s\n\n%s',
        divider,
        (new Date()).toUTCString(),
        load,
        divider,
        stdout.toString()
      );

      fs.write(fd, event, null, 'utf8', function(err) {
        if (err) { throw err; }
        setTimeout(check.bind(null, fd), program.sleep * 1000);
      });
    });
  });
};

fs.open(program.log, 'a', function(err, fd) {
  if (err) { throw err; }

  process.on('SIGINT', process.exit);
  process.on('SIGTERM', process.exit);
  process.on('exit', function() {
    fs.close(fd);
  });

  check(fd);
});
