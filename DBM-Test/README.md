# Tests for Deadly Boss Mods

This is WIP and not yet ready for general use.

## Testing boss mods

DBM tests are [characterization tests](https://en.wikipedia.org/wiki/Characterization_test), they replay a log of events gathered during a boss fight and recording how DBM responds.
Test runs output a plain text test report that summarize the behavior of a mod.
The flow for adding a new test is:

1. Use Transcriptor to record a boss fight
2. Define a test case for a boss mod based on the log (TODO: link to example)
3. Run the test via `/dbm test <test name>` to get a test report
4. Manually inspect the test report to validate that the mod is doing what you expect it to do
5. The test report will also point out potential problems such as unused timers or spell ID mismatches (NYI)
6. Store the test report together with the test data as a "golden"

Running the test again later will compare the output to the previously stored result.
This can be used to either verify that changes to DBM (say the upcoming Timer v2 refactoring) did not change the behavior of mods or to check if a change to a mod indeed had the intended effect.

If you make a change to a boss mod covered by such a test you would also update the golden file and include the diff in your commit.
This makes reviewing changes to mods also easier because you can also see the actual effect a change had on the observed behavior.


## Limitations

A lot! Too many to list exhaustively here.
Basically it currently just works for very simple cases: timers and warnings.
A few notable limitations:

* Transcriptor cannot record destFlags (and recording sourceFlags requires an obscure option)
* Replaying tests is done in real time -- so running a full test suite on all mods would be very slow
* There are several problems with determinism, e.g., results will differ based on current settings, your class and spec, etc...
* The report output is not yet stable, so don't add lots of goldens yet, these will change a lot
