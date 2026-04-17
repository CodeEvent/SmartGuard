from .unlimited_mint import UnlimitedMint
from .fake_token_name import FakeTokenName
from .unprotected_critical_function import UnprotectedCriticalFunction

def make_plugin():
    return [UnlimitedMint, FakeTokenName, UnprotectedCriticalFunction], []