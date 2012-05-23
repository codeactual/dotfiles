#!/usr/bin/env node

// Based on http://www.linuxquestions.org/questions/linux-server-73/run-a-script-if-the-server-load-is-above-a-certain-value-853872/#post4211665

var exec = require('child_process').exec,
    fs = require('fs'),
    program = require('commander'),
    util = require('util'),
    divider = '-------------------------------';

program
  .option('-l, --log <file>')
  .option('-m, --min <#>', 'Minimum cpu usage to trigger logging, ex. 50', Number)
  .option('-s, --sleep <#>', 'Seconds between checks', Number)
  .parse(process.argv);

if (!program.log || !program.min || !program.sleep) {
  console.err('See --help for usage.');
  process.exit(1);
}
var check = function(fd) {
  exec('COLUMNS=300 top -b -n 1 -c | head -n 32', null, function(err, stdout, stderr) {
    if (err) { throw err; }

    var user = parseFloat(stdout.toString().match(/Cpu\(s\):\s+(.*)%us/m)[1], 10);

    if (user < program.min) {
      setTimeout(check.bind(null, fd), program.sleep * 1000);
      return;
    }

    var event = util.format(
      '\n%s\n%s\nuser: %d\n%s\n\n%s',
      divider,
      (new Date()).toUTCString(),
      user,
      divider,
      stdout.toString()
    );

    fs.write(fd, event, null, 'utf8', function(err) {
      if (err) { throw err; }
      setTimeout(check.bind(null, fd), program.sleep * 1000);
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
