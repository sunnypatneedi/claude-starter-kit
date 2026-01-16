# MCP Server Configurations

This directory contains configuration files for Model Context Protocol (MCP) servers. MCP servers extend Claude's capabilities with external tools and data sources.

## Available Configurations

### GitHub (`github.json`)

Connect Claude to GitHub for repository management, issue tracking, and PR workflows.

### Linear (`linear.json`)

Project management integration for Linear users.

### Slack (`slack.json`)

Team communication integration for posting updates and reading channels.

### PostgreSQL (`postgres.json`)

Database access for querying and managing PostgreSQL databases.

### Notion (`notion.json`)

Documentation and knowledge base integration.

### Filesystem (`filesystem.json`)

Extended filesystem access with specific directory permissions.

## Setup Instructions

### 1. Install MCP Server

Each configuration requires its corresponding MCP server to be installed:

```bash
# GitHub
npm install -g @anthropic/mcp-server-github

# PostgreSQL
npm install -g @anthropic/mcp-server-postgres

# Filesystem
npm install -g @anthropic/mcp-server-filesystem
```

### 2. Configure Credentials

Each server requires specific credentials. Set them as environment variables:

```bash
# GitHub
export GITHUB_TOKEN="your-github-token"

# Linear
export LINEAR_API_KEY="your-linear-key"

# Slack
export SLACK_BOT_TOKEN="your-slack-token"

# PostgreSQL
export DATABASE_URL="postgres://user:pass@host:5432/db"

# Notion
export NOTION_API_KEY="your-notion-key"
```

### 3. Add to Claude Settings

Add the MCP server configuration to your Claude settings:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

## Customization

Each `.json` file in this directory is a template. Copy and modify for your specific setup:

1. Copy the template: `cp github.json my-github.json`
2. Update environment variables and paths
3. Add to your Claude settings

## Security Notes

- Never commit actual credentials to version control
- Use environment variables or secrets managers
- Review server permissions before enabling
- Limit access to specific repositories/channels/tables as needed
