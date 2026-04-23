# Project Brief — SingAI

## Purpose
Open-source Flutter app that converts speech/text into sign language via an animated avatar. Designed for NGOs serving deaf communities. All AI processing is **on-device** (offline-first, zero cloud cost).

## Target Users
- NGO staff communicating with deaf/hard-of-hearing individuals
- Deaf community members

## Core Requirements
- Offline-first: no data leaves the device
- Free to use (no cloud API costs)
- Android (API 21+) & iOS (12+)
- Support multiple sign language variants (ASL, BSL, Arabic SL)

## MVP Scope
1. Record voice → transcribe (Whisper local)
2. Normalize text (local RAG)
3. Map words → sign tokens
4. Render animated avatar
5. Cache translations locally
6. Export/share translation
