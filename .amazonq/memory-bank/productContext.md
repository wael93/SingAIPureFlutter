# Product Context — SingAI

## Problem
70M+ deaf people face daily communication barriers. NGOs serving them need free, offline, easy-to-use tools.

## Solution
SingAI converts speech or text → animated sign language avatar, entirely on-device.

## Data Flow
```
🎙️ Voice / ✍️ Text
      ↓
🧠 STT  (flutter_whisper — local Whisper model)
      ↓
📝 Text Normalization  (RAGNormalizer — local RAG)
      ↓
🤟 Sign Mapping  (SignMapper → SignDatabase)
      ↓
🧑‍💻 Avatar Render  (AvatarPlayer / AvatarService)
      ↓
💾 Local Cache  (Hive)
```

## Key UX Principles
- Works with zero internet connection
- Fast: cached content <3 s, new content <8 s, avatar render <5 s
- Accessible: high-contrast mode, screen-reader support
- Simple enough for non-technical NGO staff

## Feature Status
| Feature | Status |
|---|---|
| Voice recording | ✅ Done |
| STT (Whisper local) | ✅ Done |
| Text normalization (RAG) | ✅ Done |
| Sign mapping | ✅ Done |
| Local cache | ✅ Done |
| Model management | ✅ Done |
| Settings page | ✅ Done |
| Usage dashboard | ✅ Done |
| Avatar rendering | 🔄 In progress |
| Export / share | 🔄 In progress |
| Full home page | 🔄 In progress |
