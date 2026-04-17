from slither.detectors.abstract_detector import AbstractDetector, DetectorClassification

class UnlimitedMint(AbstractDetector):
    ARGUMENT = "unlimited-mint"
    HELP = "Detects mint/addReward functions without supply cap or access control"
    IMPACT = DetectorClassification.HIGH
    CONFIDENCE = DetectorClassification.MEDIUM
    WIKI = "https://github.com/ermand87123/smartguard"
    WIKI_TITLE = "Unlimited Mint Detection"
    WIKI_DESCRIPTION = "Detects mint/addReward functions that lack access control or supply caps"
    WIKI_EXPLOIT_SCENARIO = "Owner or anyone can mint unlimited tokens/rewards, causing inflation"
    WIKI_RECOMMENDATION = "Add onlyOwner modifier and max supply cap with require checks"

    def _detect(self):
        results = []
        mint_keywords = ['mint', 'addreward', 'createreward', 'issuetoken', 'generatetoken']
        for contract in self.compilation_unit.contracts:
            for function in contract.functions:
                if function.is_constructor or function.view or function.pure:
                    continue
                function_name_lower = function.name.lower()
                is_mint_function = any(keyword in function_name_lower for keyword in mint_keywords)
                if is_mint_function and function.visibility in ['external', 'public']:
                    has_only_owner = False
                    has_supply_cap = False
                    for modifier in function.modifiers:
                        if 'owner' in modifier.name.lower():
                            has_only_owner = True
                    function_str = str(function).lower()
                    supply_cap_indicators = [
                        'maxsupply', 'capped', 'total <=',
                        'totalsupply <=', 'require(total', 'require(_amount <='
                    ]
                    for indicator in supply_cap_indicators:
                        if indicator in function_str:
                            has_supply_cap = True
                            break
                    if not has_supply_cap:
                        for var in contract.state_variables:
                            if 'maxsupply' in var.name.lower() or 'cap' in var.name.lower():
                                has_supply_cap = True
                                break
                    if (not has_only_owner) or (has_only_owner and not has_supply_cap):
                        try:
                            line = function.source_mapping.lines[0]
                        except (AttributeError, IndexError):
                            try:
                                line = function.source_mapping.start_line
                            except AttributeError:
                                line = "unknown"
                        info = [
                            f"Unlimited mint detected in {contract.name}.{function.name} (line {line})",
                            f" ├─ Function: {function.name}",
                            f" ├─ Visibility: {function.visibility}",
                            f" ├─ Access control: {'None' if not has_only_owner else 'onlyOwner'}",
                            f" └─ Supply cap: {'None' if not has_supply_cap else 'Present'}"
                        ]
                        res = self.generate_result(info)
                        res.add(function)
                        results.append(res)
        return results