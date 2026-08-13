> Source: https://raw.githubusercontent.com/xai-org/x-algorithm/main/grox/flows/upa/state_initial_banger.py

from dataclasses import dataclass, field

from grox.flows.upa.models import ContentCategoryScore, TweetBoolMetadata


@dataclass
class BangerScreenResult:
    summary: str = ""
    tags: list[str] = field(default_factory=list)
    taxonomy_categories: list[ContentCategoryScore] = field(default_factory=list)
    tweet_bool_metadata: TweetBoolMetadata | None = None
    is_image_editable_by_grok: bool | None = None
    slop_score: int | None = None
    has_minor_score: float | None = None


@dataclass
class InitialBangerState:
    result: BangerScreenResult | None = None
    available_topics: list | None = None
