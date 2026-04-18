# SmartGuard

SmartGuard is a custom Slither plugin for detecting business-logic fraud patterns in Solidity smart contracts. It extends Slither with three detectors:

- `unlimited-mint`
- `fake-token-name`
- `unprotected-critical-function`

The project was developed as part of a BEng (Hons) Cyber Security degree project.

## Repository Structure

```text
SmartGuard/
├── contracts/
│   ├── scam/
│   └── legit/
├── detectors/
│   ├── __init__.py
│   ├── unlimited_mint.py
│   ├── fake_token_name.py
│   └── unprotected_critical_function.py
├── demo.ps1
├── setup.py
└── openzeppelin-contracts/
```

## Requirements

- Windows PowerShell
- Python 3.10.x
- Git
- Slither
- solc-select
- Solidity compiler 0.8.0

## Full Setup From the Beginning

### 1. Clone the repository

```powershell
git clone https://github.com/CodeEvent/SmartGuard.git
cd SmartGuard
```

### 2. Create and activate a virtual environment

```powershell
py -m venv venv
.\venv\Scripts\Activate.ps1
```

### 3. Install Python dependencies

```powershell
pip install --upgrade pip
pip install slither-analyzer
pip install solc-select
pip install -e .
```

### 4. Install and select Solidity compiler 0.8.0

```powershell
solc-select install 0.8.0
solc-select use 0.8.0
solc --version
```

### 5. Verify tool versions

```powershell
python --version
slither --version
```

### 6. Verify SmartGuard plugin registration

```powershell
slither --list-detectors | Select-String "unlimited-mint|fake-token-name|unprotected-critical-function"
```

## Run SmartGuard on a Single Contract

```powershell
slither .\contracts\scam\test_mint.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function
```

## Run the Full SmartGuard Evaluation Workflow

### 1. Baseline Slither without SmartGuard detectors

```powershell
mkdir results -Force
mkdir results\baseline -Force
mkdir results\extended -Force

slither contracts\scam\test_mint.sol 2>&1 | Out-File results\baseline\test_mint.txt
slither contracts\scam\scam_fake_eth.sol 2>&1 | Out-File results\baseline\scam_fake_eth.txt
slither contracts\scam\vulnerable_owner.sol 2>&1 | Out-File results\baseline\vulnerable_owner.txt
slither contracts\scam\external\stratos_unlimited.sol 2>&1 | Out-File results\baseline\stratos.txt

slither contracts\legit\test.sol 2>&1 | Out-File results\baseline\test.txt
slither contracts\legit\openzeppelin\ERC20.sol 2>&1 | Out-File results\baseline\ERC20.txt
slither contracts\legit\openzeppelin\Ownable.sol 2>&1 | Out-File results\baseline\Ownable.txt
```

### 2. Extended Slither with SmartGuard detectors

```powershell
slither contracts\scam\test_mint.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Out-File results\extended\test_mint.txt
slither contracts\scam\scam_fake_eth.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Out-File results\extended\scam_fake_eth.txt
slither contracts\scam\vulnerable_owner.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Out-File results\extended\vulnerable_owner.txt
slither contracts\scam\external\stratos_unlimited.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Out-File results\extended\stratos.txt

slither contracts\legit\test.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Out-File results\extended\test.txt
slither contracts\legit\openzeppelin\ERC20.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Out-File results\extended\ERC20.txt
slither contracts\legit\openzeppelin\Ownable.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Out-File results\extended\Ownable.txt
```

### 3. Run the complete dataset evaluation

```powershell
"SmartGuard Comprehensive Evaluation Results" | Out-File results\comprehensive_results.txt
"Date: $(Get-Date)" | Out-File results\comprehensive_results.txt -Append
"=" * 60 | Out-File results\comprehensive_results.txt -Append

"SCAM CONTRACTS:" | Out-File results\comprehensive_results.txt -Append
Get-ChildItem contracts\scam -Recurse -Filter *.sol | ForEach-Object {
    "Testing: $($_.Name)" | Out-File results\comprehensive_results.txt -Append
    slither $_.FullName --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Out-File results\comprehensive_results.txt -Append
    "-" * 40 | Out-File results\comprehensive_results.txt -Append
}

"LEGITIMATE CONTRACTS:" | Out-File results\comprehensive_results.txt -Append
Get-ChildItem contracts\legit -Recurse -Filter *.sol | ForEach-Object {
    "Testing: $($_.Name)" | Out-File results\comprehensive_results.txt -Append
    slither $_.FullName --detect unlimited-mint,fake-token-name,unprotected-critical-function 2>&1 | Out-File results\comprehensive_results.txt -Append
    "-" * 40 | Out-File results\comprehensive_results.txt -Append
}
```

### 4. Optional JSON reports

```powershell
mkdir results\json -Force

slither contracts\scam\test_mint.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function --json results\json\test_mint.json
slither contracts\scam\scam_fake_eth.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function --json results\json\scam_fake_eth.json
slither contracts\scam\vulnerable_owner.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function --json results\json\vulnerable_owner.json
slither contracts\scam\external\stratos_unlimited.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function --json results\json\stratos_unlimited.json
```

## Run the Demo Script

### 1. Open PowerShell in the project root

```powershell
cd SmartGuard
```

### 2. Activate the virtual environment

```powershell
.\venv\Scripts\Activate.ps1
```

### 3. Make sure dependencies are installed

```powershell
pip install slither-analyzer
pip install solc-select
pip install -e .
solc-select install 0.8.0
solc-select use 0.8.0
```

### 4. Verify detectors before the live demo

```powershell
slither --list-detectors | Select-String "unlimited-mint|unprotected-critical-function|fake-token-name"
```

### 5. Run the demo

```powershell
.\demo.ps1
```

## What `demo.ps1` Shows

The demo script walks through four stages:

1. Verifies SmartGuard detectors are registered
2. Runs baseline Slither on `stratos_unlimited.sol`
3. Runs SmartGuard on the same contract
4. Runs SmartGuard on a legitimate OpenZeppelin contract to show zero false positives

## Troubleshooting

### Detectors do not appear

```powershell
pip uninstall smartguard -y
pip install -e .
pip show smartguard
slither --list-detectors | Select-String "smartguard|unlimited-mint|fake-token-name|unprotected-critical-function"
```

### Slither cannot compile contracts

```powershell
pip install solc-select
solc-select install 0.8.0
solc-select use 0.8.0
solc --version
```

### Check installed packages

```powershell
pip list | Select-String "slither|smartguard|solc"
```

## Notes

- The repository currently includes `contracts`, `detectors`, `openzeppelin-contracts`, `demo.ps1`, and `setup.py`. The `demo.ps1` script is present at the root of the repository. The repo page did not show a README file at the time of review, so this file is intended as a ready-to-paste replacement. 
