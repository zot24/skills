<!-- Source: https://chat-sdk.dev/docs/customization/artifacts -->

# Artifacts

Artifacts is a special user interface mode that allows you to have a workspace-like interface along with the chat interface. This is similar to ChatGPT's Canvas and Claude's Artifacts.

## Built-in Artifacts

The template ships with the following artifacts:

- **Text Artifact**: Work with text content like drafting essays and emails
- **Code Artifact**: Write and execute code snippets
- **Image Artifact**: Work with images like editing, annotating, and processing images
- **Sheet Artifact**: Work with tabular data like creating, editing, and analyzing data

## Adding a Custom Artifact

To add a custom artifact, create a folder in the `artifacts` directory with the artifact name. The folder should contain:

- `client.tsx`: The client-side code for the artifact
- `server.ts`: The server-side code for the artifact

```bash
artifacts/
  custom/
    client.tsx
    server.ts
```

### Client-Side Example (`client.tsx`)

This file is responsible for rendering your custom artifact:

```tsx
import { Artifact } from "@/components/create-artifact";
import { ExampleComponent } from "@/components/example-component";
import { toast } from "sonner";

interface CustomArtifactMetadata {
  info: string;
}

export const customArtifact = new Artifact<"custom", CustomArtifactMetadata>({
  kind: "custom",
  description: "A custom artifact for demonstrating custom functionality.",
  initialize: async ({ documentId, setMetadata }) => {
    setMetadata({
      info: `Document ${documentId} initialized.`,
    });
  },
  onStreamPart: ({ streamPart, setMetadata, setArtifact }) => {
    if (streamPart.type === "info-update") {
      setMetadata((metadata) => ({
        ...metadata,
        info: streamPart.content as string,
      }));
    }
    if (streamPart.type === "content-update") {
      setArtifact((draftArtifact) => ({
        ...draftArtifact,
        content: draftArtifact.content + (streamPart.content as string),
        status: "streaming",
      }));
    }
  },
  content: ({
    mode,
    status,
    content,
    isCurrentVersion,
    currentVersionIndex,
    onSaveContent,
    getDocumentContentById,
    isLoading,
    metadata,
  }) => {
    if (isLoading) {
      return <div>Loading custom artifact...</div>;
    }

    if (mode === "diff") {
      const oldContent = getDocumentContentById(currentVersionIndex - 1);
      const newContent = getDocumentContentById(currentVersionIndex);
      return (
        <div>
          <h3>Diff View</h3>
          <pre>{oldContent}</pre>
          <pre>{newContent}</pre>
        </div>
      );
    }

    return (
      <div className="custom-artifact">
        <ExampleComponent
          content={content}
          metadata={metadata}
          onSaveContent={onSaveContent}
          isCurrentVersion={isCurrentVersion}
        />
        <button
          onClick={() => {
            navigator.clipboard.writeText(content);
            toast.success("Content copied to clipboard!");
          }}
        >
          Copy
        </button>
      </div>
    );
  },
  actions: [
    {
      icon: <span>&#x27F3;</span>,
      description: "Refresh artifact info",
      onClick: ({ appendMessage }) => {
        appendMessage({
          role: "user",
          content: "Please refresh the info for my custom artifact.",
        });
      },
    },
  ],
  toolbar: [
    {
      icon: <span>&#x270E;</span>,
      description: "Edit custom artifact",
      onClick: ({ appendMessage }) => {
        appendMessage({
          role: "user",
          content: "Edit the custom artifact content.",
        });
      },
    },
  ],
});
```

### Server-Side Example (`server.ts`)

The server file processes the document for the artifact, streaming updates and returning final content:

```ts
import { smoothStream, streamText } from "ai";
import { myProvider } from "@/lib/ai/providers";
import { createDocumentHandler } from "@/lib/artifacts/server";
import { updateDocumentPrompt } from "@/lib/ai/prompts";

export const customDocumentHandler = createDocumentHandler<"custom">({
  kind: "custom",
  onCreateDocument: async ({ title, dataStream }) => {
    let draftContent = "";
    const { fullStream } = streamText({
      model: myProvider.languageModel("artifact-model"),
      system:
        "Generate a creative piece based on the title. Markdown is supported.",
      experimental_transform: smoothStream({ chunking: "word" }),
      prompt: title,
    });

    for await (const delta of fullStream) {
      if (delta.type === "text-delta") {
        draftContent += delta.textDelta;
        dataStream.writeData({
          type: "content-update",
          content: delta.textDelta,
        });
      }
    }

    return draftContent;
  },
  onUpdateDocument: async ({ document, description, dataStream }) => {
    let draftContent = "";
    const { fullStream } = streamText({
      model: myProvider.languageModel("artifact-model"),
      system: updateDocumentPrompt(document.content, "custom"),
      experimental_transform: smoothStream({ chunking: "word" }),
      prompt: description,
      experimental_providerMetadata: {
        openai: {
          prediction: {
            type: "content",
            content: document.content,
          },
        },
      },
    });

    for await (const delta of fullStream) {
      if (delta.type === "text-delta") {
        draftContent += delta.textDelta;
        dataStream.writeData({
          type: "content-update",
          content: delta.textDelta,
        });
      }
    }

    return draftContent;
  },
});
```

### Registration Steps

Once you have created the client and server files, register the artifact in three places:

**1. Add server handler in `lib/artifacts/server.ts`:**

```ts
export const documentHandlersByArtifactKind: Array<DocumentHandler> = [
  ...,
  customDocumentHandler,
];

export const artifactKinds = [..., "custom"] as const;
```

**2. Add to database schema in `lib/db/schema.ts`:**

```ts
export const document = pgTable(
  "Document",
  {
    id: uuid("id").notNull().defaultRandom(),
    createdAt: timestamp("createdAt").notNull(),
    title: text("title").notNull(),
    content: text("content"),
    kind: varchar("text", { enum: [..., "custom"] })
      .notNull()
      .default("text"),
    userId: uuid("userId")
      .notNull()
      .references(() => user.id),
  },
  (table) => {
    return {
      pk: primaryKey({ columns: [table.id, table.createdAt] }),
    };
  },
);
```

**3. Add client artifact to `components/artifact.tsx`:**

```ts
import { customArtifact } from "@/artifacts/custom/client";

export const artifactDefinitions = [..., customArtifact];
```

You should now be able to see the custom artifact in the workspace.
