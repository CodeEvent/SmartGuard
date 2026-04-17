from slither.detectors.abstract_detector import AbstractDetector, DetectorClassification

class FakeTokenName(AbstractDetector):
    ARGUMENT = "fake-token-name"
    HELP = "Detects tokens impersonating well-known tokens"
    IMPACT = DetectorClassification.MEDIUM
    CONFIDENCE = DetectorClassification.MEDIUM
    WIKI = "https://github.com/ermand87123/smartguard"
    WIKI_TITLE = "Fake Token Name Detection"
    WIKI_DESCRIPTION = "Detects tokens using names of well-known tokens to deceive users"
    WIKI_EXPLOIT_SCENARIO = "Attacker creates token named 'Ethereum' or 'Evo' to trick users"
    WIKI_RECOMMENDATION = "Verify token contract addresses from trusted sources"

    def _detect(self):
        results = []
        well_known_names = [
            'ethereum', 'eth', 'weth','usdc', 'usdt', 'dai',
            'uniswap', 'chainlink', 'evo'
        ]
        for contract in self.compilation_unit.contracts:
            for var in contract.state_variables:
                if var.name.lower() in ['name', 'symbol']:
                    if var.expression:
                        value = str(var.expression).lower().strip('"').strip("'")
                        for known in well_known_names:
                            if known in value and contract.name.lower() != known:
                                try:
                                    line = var.source_mapping.lines[0]
                                except:
                                    line = "unknown"
                                info = [
                                    f"Fake token name detected: '{value}' impersonating '{known}' in {contract.name} (line {line})",
                                    f" ├─ Contract: {contract.name}",
                                    f" ├─ Variable: {var.name} = '{value}'",
                                    f" └─ Impersonating: {known}"
                                ]
                                res = self.generate_result(info)
                                res.add(var)
                                results.append(res)
        return results