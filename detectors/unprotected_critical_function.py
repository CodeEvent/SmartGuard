from slither.detectors.abstract_detector import AbstractDetector, DetectorClassification

class UnprotectedCriticalFunction(AbstractDetector):
    ARGUMENT = "unprotected-critical-function"
    HELP = "Detects critical functions without access control"
    IMPACT = DetectorClassification.HIGH
    CONFIDENCE = DetectorClassification.MEDIUM
    WIKI = "https://github.com/ermand87123/smartguard"
    WIKI_TITLE = "Unprotected Critical Function Detection"
    WIKI_DESCRIPTION = "Detects critical functions like withdraw, mint, setOwner that lack access control modifiers."
    WIKI_EXPLOIT_SCENARIO = "Anyone can call setOwner() or withdraw() to steal funds or take ownership."
    WIKI_RECOMMENDATION = "Add access control modifiers (onlyOwner, onlyAdmin) to all critical functions."

    def _detect(self):
        results = []
        CRITICAL_KEYWORDS = ["setowner", "withdraw", "mint", "pause", "upgrade", "admin", "change"]
        for contract in self.compilation_unit.contracts:
            for f in contract.functions:
                if f.visibility in ['external', 'public'] and any(kw in f.name.lower() for kw in CRITICAL_KEYWORDS):
                    has_owner_mod = any(
                        "owner" in mod.name.lower() or "admin" in mod.name.lower() or "only" in mod.name.lower()
                        for mod in f.modifiers
                    )
                    if not has_owner_mod:
                        line_number = f.source_mapping.lines[0] if f.source_mapping.lines else "unknown"
                        info = f"Unprotected critical function: {contract.name}.{f.name} (line {line_number})"
                        res = self.generate_result([info])
                        res.add(f)
                        results.append(res)
        return results