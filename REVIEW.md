| Check          | Sub-check                                                                         | Who | Completion Date | Issue #'s |
|----------------|-----------------------------------------------------------------------------------|-----|-----------------|-----------|
|Logical checks| Proper profile directory structure							|Eugene Aronne|11/19/2018|*|
||JSON output review (e.g., pass/fail on ,<br>hardened, not hardened, edge cases, etc.)|Eugene Aronne|11/26/2018|*|
||InSpec syntax checker|Eugene Aronne|11/26/2018|*|
||Local commands focused on target not the runner|Eugene Aronne|11/26/2018|*|
|Quality checks|Alignment (including tagging) to original<br> standard (i.e. STIG, CIS Benchmark, NIST Tags)|Eugene Aronne|11/26/2018|*|
||Descriptive output for findings details|Eugene Aronne|11/26/2018|*|
||Documentation quality (i.e. README)<br> novice level instructions including prerequisites|Eugene Aronne|11/26/2018|*|
||Consistency across other profile conventions |Eugene Aronne|11/21/2018|3,4,5|
||Spelling grammar|Eugene Aronne|11/19/2018|*|
||Removing debugging documentation and code|Eugene Aronne|11/26/2018|*|
| Error handling |“Profile Error” containment: “null” responses <br>should only happen if InSpec is run with incorrect privileges|Eugene Aronne|11/19/2018|*|
||Slowing the target (e.g. filling up disk, CPU spikes)|Eugene Aronne|11/26/2018|*|
||Check for risky commands (e.g. rm, del, purge, etc.)|Eugene Aronne|11/19/2018|*|
||Check for “stuck” situations (e.g., profile goes on forever)|Eugene Aronne|11/19/2018|*|
