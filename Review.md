| Check          | Sub-check                                                                         | Who | Completion Date | Issue #'s |
|----------------|-----------------------------------------------------------------------------------|-----|-----------------|-----------|
|Logical checks| Proper profile directory structure							|*|*|*|
||JSON output review (e.g., pass/fail on ,<br>hardened, not hardened, edge cases, etc.)|*|*|*|
||InSpec syntax checker|*|*|*|
||Local commands focused on target not the runner|*|*|*|
|Quality checks|Alignment (including tagging) to original<br> standard (i.e. STIG, CIS Benchmark, NIST Tags)|*|*|*|
||Descriptive output for findings details|*|*|*|
||Documentation quality (i.e. README)<br> novice level instructions including prerequisites|*|*|*|
||Consistency across other profile conventions |Eugene Aronne|*|3,4,5|
||Spelling grammar|Eugene Aronne|11/19/2018|*|
||Removing debugging documentation and code|*|*|*|
| Error handling |“Profile Error” containment: “null” responses <br>should only happen if InSpec is run with incorrect privileges|Eugene Aronne|11/19/2018|*|
||Slowing the target (e.g. filling up disk, CPU spikes)|*|*|*|
||Check for risky commands (e.g. rm, del, purge, etc.)|Eugene Aronne|11/19/2018|*|
||Check for “stuck” situations (e.g., profile goes on forever)|Eugene Aronne|11/19/2018|*|
