<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/using-filters -->

# Using Filters

## Overview

Honcho offers a sophisticated filtering mechanism that enables precise querying of workspaces, peers, sessions, and messages through dictionaries defining matching conditions.

## Core Filter Types

**Simple Filters**: Basic equality matching for exact resource identification.

**Logical Operators**: Combine conditions using AND, OR, and NOT operators for sophisticated query construction.

**Comparison Operators**: Enable range queries and pattern matching with operators like `gte`, `lte`, `gt`, `lt`, `ne`, `in`, and `contains`.

## Logical Operators Explained

- **AND**: Requires all specified conditions to evaluate as true
- **OR**: Matches any of the provided conditions
- **NOT**: Excludes resources matching specified criteria
- **Combined**: Nesting different operators creates complex multi-layered queries

## Comparison Operators

Available operators include:
- `gte` (greater than or equal)
- `lte` (less than or equal)
- `gt` (greater than)
- `lt` (less than)
- `ne` (not equal)
- `in` (membership in a list)
- `contains` (substring matching)
- `icontains` (case-insensitive substring matching)

## Metadata Filtering

Metadata supports nested object structures and comparison operators. Make sure not to create metadata fields that use the same names as the included comparison operators.

## Wildcards

The asterisk (*) matches any value for a field, enabling flexible filtering patterns.

## Error Management

Both Python and TypeScript implementations provide error handling through try-catch blocks for invalid operators or nonexistent fields.
