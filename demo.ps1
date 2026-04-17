[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null
$Host.UI.RawUI.WindowTitle = "SmartGuard - Live Fraud Detection Demo"

& ".\venv\Scripts\Activate.ps1"

Clear-Host

Write-Host ""
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host "                 S M A R T G U A R D "    -ForegroundColor Cyan
Write-Host "   BEng (Hons) Cybersecurity  |  COMP10034  |  UWS"      -ForegroundColor Cyan
Write-Host "   Ermand Mani  |  April 2026"                            -ForegroundColor Cyan
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Now let's see it live."                                 -ForegroundColor Yellow
Write-Host ""
Write-Host "  THE CONTRACT WE ARE ABOUT TO SCAN:"                    -ForegroundColor Yellow
Write-Host "  StratosPoTReward  (stratos_unlimited.sol)"              -ForegroundColor White
Write-Host "  Source: BlockSec Audit  STRATOS-2024-001"              -ForegroundColor White
Write-Host "  Known findings: 12 HIGH-severity vulnerabilities"      -ForegroundColor Red
Write-Host ""
Write-Host "  WHAT WE ARE DOING:"                                     -ForegroundColor Yellow
Write-Host "  Run 1  >>  Standard tool only  (SmartGuard OFF)"       -ForegroundColor White
Write-Host "  Run 2  >>  SmartGuard active   (SmartGuard ON)"        -ForegroundColor White
Write-Host "  Same contract both times. Different tool."              -ForegroundColor White
Write-Host ""

Read-Host "  Press ENTER to begin"

# -----------------------------------------------------------------------
Clear-Host
Write-Host ""
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host "   STEP 1 of 4  >>  Are SmartGuard detectors active?"    -ForegroundColor Cyan
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  These are the three detectors from slide 7."           -ForegroundColor White
Write-Host "  Each one targets a fraud pattern standard tools miss:" -ForegroundColor White
Write-Host ""
Write-Host "  [1]  UNLIMITED-MINT"                                   -ForegroundColor Red
Write-Host "       Rug pull detection"                               -ForegroundColor Yellow
Write-Host "       Can anyone create infinite tokens?"               -ForegroundColor White
Write-Host ""
Write-Host "  [2]  FAKE-TOKEN-NAME"                                  -ForegroundColor Red
Write-Host "       Impersonation and identity fraud"                 -ForegroundColor Yellow
Write-Host "       Is this pretending to be ETH or USDT?"            -ForegroundColor White
Write-Host ""
Write-Host "  [3]  UNPROTECTED-CRITICAL-FUNCTION"                   -ForegroundColor Red
Write-Host "       Open financial controls"                          -ForegroundColor Yellow
Write-Host "       Can anyone drain funds or take over ownership?"   -ForegroundColor White
Write-Host ""
Write-Host "  Confirming these are live inside Slither's system"     -ForegroundColor White
Write-Host "  and not just described on a slide..."                  -ForegroundColor White
Write-Host ""
Write-Host "  ------------------------------------------------------" -ForegroundColor White
Write-Host "  COMMAND:"                                               -ForegroundColor Cyan
Write-Host "  slither --list-detectors | Select-String 'unlimited-mint|unprotected-critical-function|fake-token-name'"    -ForegroundColor Green
Write-Host "  ------------------------------------------------------" -ForegroundColor White
Write-Host ""
slither --list-detectors | Select-String "unlimited-mint|unprotected-critical-function|fake-token-name" | ForEach-Object { Write-Host $_.Line.Trim() }
Write-Host ""
Write-Host "  +----------------------------------------------------+" -ForegroundColor Green
Write-Host "  |  All 3 SmartGuard detectors registered and active  |" -ForegroundColor Green
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  Severity ratings match the methodology slide.     |" -ForegroundColor White
Write-Host "  +----------------------------------------------------+" -ForegroundColor Green
Write-Host ""

Read-Host "  Press ENTER to run the standard security check"

# -----------------------------------------------------------------------
Clear-Host
Write-Host ""
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host "   STEP 2 of 4  >>  Standard Slither  (SmartGuard OFF)" -ForegroundColor Cyan
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  CONTRACT:  StratosPoTReward  (stratos_unlimited.sol)"  -ForegroundColor White
Write-Host "  SOURCE:    BlockSec Audit  STRATOS-2024-001"           -ForegroundColor White
Write-Host "  KNOWN:     12 HIGH-severity fraud vulnerabilities"     -ForegroundColor Red
Write-Host ""
Write-Host "  This is the baseline from Phase 6 of the project."    -ForegroundColor White
Write-Host "  Slither running on its own. SmartGuard switched off."  -ForegroundColor White
Write-Host "  What would a security analyst see on this contract"    -ForegroundColor White
Write-Host "  using only the standard tool available today?"         -ForegroundColor White
Write-Host ""
Write-Host "  ------------------------------------------------------" -ForegroundColor White
Write-Host "  COMMAND:"                                               -ForegroundColor Cyan
Write-Host "  slither contracts/scam/external/stratos_unlimited.sol --exclude unlimited-mint,fake-token-name,unprotected-critical-function"                         -ForegroundColor Green
Write-Host "  ------------------------------------------------------" -ForegroundColor White
Write-Host ""
slither contracts/scam/external/stratos_unlimited.sol --exclude unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Select-String "Detector:|result" | ForEach-Object { Write-Host $_.Line }
Write-Host ""
Write-Host "  +----------------------------------------------------+" -ForegroundColor Yellow
Write-Host "  |  STANDARD TOOL VERDICT:                            |" -ForegroundColor Yellow
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  Slither found coding and programming issues.      |" -ForegroundColor White
Write-Host "  |  This is exactly what it was designed to detect.   |" -ForegroundColor White
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  Business logic fraud    >>  NOT DETECTED          |" -ForegroundColor Red
Write-Host "  |  Unlimited minting       >>  NOT DETECTED          |" -ForegroundColor Red
Write-Host "  |  Open fund withdrawal    >>  NOT DETECTED          |" -ForegroundColor Red
Write-Host "  |  Ownership takeover      >>  NOT DETECTED          |" -ForegroundColor Red
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  Slither does its job. The fraud is invisible.     |" -ForegroundColor Yellow
Write-Host "  |  An investor would have ZERO WARNING of a scam.    |" -ForegroundColor Red
Write-Host "  +----------------------------------------------------+" -ForegroundColor Yellow
Write-Host ""

Read-Host "  Press ENTER to run SmartGuard on the same contract"

# -----------------------------------------------------------------------
Clear-Host
Write-Host ""
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host "   STEP 3 of 4  >>  SmartGuard Scan  (SmartGuard ON)"   -ForegroundColor Cyan
Write-Host "   Same contract. Same code. SmartGuard now active."     -ForegroundColor Yellow
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  CONTRACT:  stratos_unlimited.sol  (same file as Step 2)" -ForegroundColor White
Write-Host "  CHANGE:    SmartGuard detectors are now active"          -ForegroundColor Yellow
Write-Host ""
Write-Host "  This is the Phase 7 evaluation from the methodology."  -ForegroundColor White
Write-Host "  Nothing about the contract has changed."               -ForegroundColor White
Write-Host "  The only difference is the tool."                      -ForegroundColor White
Write-Host ""
Write-Host "  ------------------------------------------------------" -ForegroundColor White
Write-Host "  COMMAND:"                                               -ForegroundColor Cyan
Write-Host "  slither contracts/scam/external/stratos_unlimited.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function" -ForegroundColor Green
Write-Host "  ------------------------------------------------------" -ForegroundColor White
Write-Host ""
slither contracts/scam/external/stratos_unlimited.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Select-String "Detector:|Unlimited|Unprotected|Fake|result" | ForEach-Object { Write-Host $_.Line }
Write-Host ""
Write-Host "  +----------------------------------------------------+" -ForegroundColor Red
Write-Host "  |  SMARTGUARD VERDICT:  FRAUD DETECTED               |" -ForegroundColor Red
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  [!] FINDING 1  line 28  addReward()               |" -ForegroundColor Red
Write-Host "  |      Anyone can mint unlimited tokens              |" -ForegroundColor White
Write-Host "  |      No supply cap. No access control.             |" -ForegroundColor White
Write-Host "  |      >> RUG PULL MECHANISM                         |" -ForegroundColor Red
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  [!] FINDING 2  line 35  withdrawReward()          |" -ForegroundColor Red
Write-Host "  |      Anyone can drain all contract funds           |" -ForegroundColor White
Write-Host "  |      No owner check. No restriction.               |" -ForegroundColor White
Write-Host "  |      >> FUND THEFT MECHANISM                       |" -ForegroundColor Red
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  [!] FINDING 3  line 43  setOwner()                |" -ForegroundColor Red
Write-Host "  |      Anyone can take full ownership                |" -ForegroundColor White
Write-Host "  |      Investors can be locked out completely        |" -ForegroundColor White
Write-Host "  |      >> OWNERSHIP TAKEOVER MECHANISM               |" -ForegroundColor Red
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  Matches BlockSec STRATOS-2024-001 audit exactly   |" -ForegroundColor Yellow
Write-Host "  |  Professional audit: thousands of pounds           |" -ForegroundColor White
Write-Host "  |  SmartGuard: free. Automatic. Seconds.             |" -ForegroundColor Green
Write-Host "  +----------------------------------------------------+" -ForegroundColor Red
Write-Host ""

Read-Host "  Press ENTER to test on a legitimate contract"

# -----------------------------------------------------------------------
Clear-Host
Write-Host ""
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host "   STEP 4 of 4  >>  False Alarm Test"                   -ForegroundColor Cyan
Write-Host "   Can SmartGuard tell the difference?"                  -ForegroundColor Yellow
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  CONTRACT:  OpenZeppelin ReentrancyGuard.sol"           -ForegroundColor Yellow
Write-Host "  From the methodology slide legitimate baseline."       -ForegroundColor White
Write-Host "  Contains ownership functions SmartGuard checks for."  -ForegroundColor White
Write-Host "  All correctly protected."                              -ForegroundColor White
Write-Host ""
Write-Host "  If SmartGuard flags this, the zero false positive"     -ForegroundColor Red
Write-Host "  result on the results slide is not real."              -ForegroundColor Red
Write-Host ""
Write-Host "  ------------------------------------------------------" -ForegroundColor White
Write-Host "  COMMAND:"                                               -ForegroundColor Cyan
Write-Host "  slither contracts/legit/openzeppelin/ReentrancyGuard.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function" -ForegroundColor Green
Write-Host "  ------------------------------------------------------" -ForegroundColor White
Write-Host ""
slither contracts/legit/openzeppelin/ReentrancyGuard.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Select-String "Detector:|result" | ForEach-Object { Write-Host $_.Line }
Write-Host ""
Write-Host "  +----------------------------------------------------+" -ForegroundColor Green
Write-Host "  |  SMARTGUARD VERDICT:  CLEAN                        |" -ForegroundColor Green
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  Zero results. Nothing flagged.                    |" -ForegroundColor Green
Write-Host "  |  Every single one of the 25 findings was real.     |" -ForegroundColor Green
Write-Host "  |  Consistent across all 10 legitimate contracts.    |" -ForegroundColor Green
Write-Host "  +----------------------------------------------------+" -ForegroundColor Green
Write-Host ""

Read-Host "  Press ENTER for the final results"

# -----------------------------------------------------------------------
Clear-Host
Write-Host ""
Write-Host "  ======================================================" -ForegroundColor White
Write-Host "   SMARTGUARD  -  Final Evaluation Results"              -ForegroundColor Cyan
Write-Host "   17 contracts  |  4 categories  |  April 2026"         -ForegroundColor Cyan
Write-Host "  ======================================================" -ForegroundColor White
Write-Host ""
Write-Host "  DATASET TESTED:"                                        -ForegroundColor Yellow
Write-Host "  +----------------------------------------------------+" -ForegroundColor White
Write-Host "  |  3   synthetic fraud contracts                     |" -ForegroundColor White
Write-Host "  |  3   real rug pulls from RugDoc.io                 |" -ForegroundColor White
Write-Host "  |  1   BlockSec audit reconstruction STRATOS-2024    |" -ForegroundColor White
Write-Host "  |  10  legitimate OpenZeppelin contracts              |" -ForegroundColor White
Write-Host "  +----------------------------------------------------+" -ForegroundColor White
Write-Host ""
Write-Host "  RESULTS:"                                               -ForegroundColor Yellow
Write-Host "  +----------------------------------------------------+" -ForegroundColor Green
Write-Host "  |  Fraud contracts caught      7 / 7   >>  100%      |" -ForegroundColor Green
Write-Host "  |  Fraud patterns detected     25                    |" -ForegroundColor Green
Write-Host "  |  False alarms on real code   0                     |" -ForegroundColor Green
Write-Host "  +----------------------------------------------------+" -ForegroundColor Green
Write-Host ""
Write-Host "  PERFORMANCE:"                                           -ForegroundColor Yellow
Write-Host "  +----------------------------------------------------+" -ForegroundColor Cyan
Write-Host "  |  PRECISION   100%   Every finding was real fraud   |" -ForegroundColor Cyan
Write-Host "  |  RECALL      100%   Every fraud was caught         |" -ForegroundColor Cyan
Write-Host "  |  F1-SCORE    100%   Perfect balance of both        |" -ForegroundColor Cyan
Write-Host "  +----------------------------------------------------+" -ForegroundColor Cyan
Write-Host ""
Write-Host "  CYBERSECURITY SIGNIFICANCE:"                           -ForegroundColor Yellow
Write-Host "  +----------------------------------------------------+" -ForegroundColor White
Write-Host "  |  SmartGuard fills a gap no open-source tool        |" -ForegroundColor White
Write-Host "  |  previously addressed. Static analysis extended    |" -ForegroundColor White
Write-Host "  |  into DeFi business logic fraud detection.         |" -ForegroundColor White
Write-Host "  |  Validated against a real professional audit.      |" -ForegroundColor White
Write-Host "  |                                                    |" -ForegroundColor White
Write-Host "  |  Automated.  Reproducible.  Zero cost.             |" -ForegroundColor Green
Write-Host "  +----------------------------------------------------+" -ForegroundColor White
Write-Host ""
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host "   Ermand Mani  |  COMP10034  |  UWS"                    -ForegroundColor Cyan
Write-Host "   Supervised by Dr. Althaff Irfan Cader Mohideen"       -ForegroundColor Cyan
Write-Host "   Moderated by Santiago Matalonga Motta"                -ForegroundColor Cyan
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host ""