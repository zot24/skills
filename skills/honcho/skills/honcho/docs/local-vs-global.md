> Source: https://honcho.dev/docs/v2/documentation/core-concepts/features/local-vs-global.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Local vs Global Representations

> Model directional relationships between Peers in Honcho

One of the unique affordances of Honcho is that it allows developers to model
directional relationships between Peers. What I mean by this is you can model
how one `Peer` thinks about another `Peer`.

There are many use cases where you don't want every agent or human to know
everything about another user such as games or multi-agent workflows. To
illustrate this, the following examples shows 2 conversations.

Conversation #1 (With Bob and Alice)

```
Alice: I had a great breakfast today.
Bob: What did you eat?
Alice: I had pancakes and eggs and bacon
```

Conversation #2 (With Alice and Charlie)

```
Alice: I actually didn't eat any breakfast today.
Charlie: Oh that's too bad.
Alice: But I lied to Bob and told him I did, so back me up if you see them.
```

Alice told Bob a lie in this conversation. If we stored both of these
conversations in Honcho with Alice, Bob, and Charlie as `Peers` and let them
use Honcho to get insights on each other then Bob would immediately know this
deception. For example:

<CodeGroup>
  ```python Python
  # Bob could run
  alice.chat("What did Alice eat today?")
  # Response: Alice did not eat anything today
  ```
</CodeGroup>

This is a problem. Bob shouldn't be able to know everything about Alice in this
situation. So to support these situations we support what we call **Local
Representations**.

By default insights generated for a `Peer` are scoped globally. This means every
message sent by that `Peer` in any conversation updates the same representation
of that `Peer`. However, we can enable **Local Representations** so Bob can
form a representation Alice based only on what they observe Alice do.

This feature is illustrated in the graphic below:

<img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/local-vs-global-reps.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=fce616196db46448a5149248d6dc3e64" alt="Peer Representations" width="2054" height="1150" data-path="images/local-vs-global-reps.png" />

We can enable local representation for a `Peer` by setting `observe_others=True`.
This is shown in the [Configure
Reasoning](/docs/v2/documentation/core-concepts/configuration) page.

Now if we used Bob's local representation of Alice then Bob would only get
insights on what they've seen Alice say to them.

```python theme={null}
bob.chat(target="alice", query="What did Alice eat today?")
# Response: Alice ate pancakes, eggs, and bacon
```


  Local Representations are turned off by default

