<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/file-uploads -->

# File Uploads

## Overview
Honcho enables document ingestion through file uploads, converting PDFs, text files, and JSON documents into messages. The system extracts content, chunks it appropriately, and integrates it into peer representations for AI agent access.

## Supported Formats
- **PDFs** with page number preservation
- **Text files** (plain text, markdown, code)
- **JSON** (structured data conversion)

## Key Process
When uploading, Honcho: extracts text using specialized processors, splits content into ~49,500 character chunks at natural boundaries (paragraphs, lines, sentences, words), and creates corresponding messages within the 50,000 character limit.

## Implementation

Both Python and TypeScript SDKs support basic upload syntax:
```python
session.upload_file(file=file, peer_id=peer_id)
```

## Querying

After upload, retrieve content via natural language queries or context methods:
```python
user.chat("What are the key findings?")
context = session.context(tokens=3000)
```

## Important Notes
- Files are processed in memory and not stored on disk. Only the extracted text content is preserved.
- Unsupported file types trigger exceptions
- Session uploads require the `peer_id` parameter
- Large documents automatically split across multiple messages

## Error Handling
Implement try-catch blocks for robustness, validate file types beforehand, use progress indicators for large files, and add retry logic for network issues.
