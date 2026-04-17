from slither.detectors.abstract_detector import AbstractDetector, DetectorClassification

class MissingZeroCheck(AbstractDetector):
    ARGUMENT = "missing-zero-check"
    HELP = "Detects owner assignment without zero-address check"
    IMPACT = DetectorClassification.LOW
    CONFIDENCE = DetectorClassification.MEDIUM
    WIKI = "https://github.com/ermand87123/smartguard"
    WIKI_TITLE = "Missing Zero Address Check"
    WIKI_DESCRIPTION = "Detects owner assignment without zero-address validation"
    WIKI_EXPLOIT_SCENARIO = "Owner can be set to the zero address, locking the contract."
    WIKI_RECOMMENDATION = "Add require(newOwner != address(0)) before assignment."

    def _detect(self):
        results = []
        for contract in self.compilation_unit.contracts:
            for function in contract.functions:
                if 'setowner' in function.name.lower():
                    function_str = str(function)
                    if 'owner =' in function_str and 'require(' not in function_str.lower():
                        try:
                            line = function.source_mapping.lines[0]
                        except (AttributeError, IndexError):
                            line = "unknown"
                        info = f"Missing zero-check in {contract.name}.{function.name} (line {line})"
                        res = self.generate_result([info])
                        res.add(function)
                        results.append(res)
        return results