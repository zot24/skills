<!-- Source: https://docs.umami.is/docs/api/teams + https://docs.umami.is/docs/api/users + https://docs.umami.is/docs/api/me -->

# Teams, Users & Me API

## Me Endpoints

| Endpoint | Purpose |
|----------|---------|
| `GET /api/me` | Current user session info |
| `GET /api/me/teams` | User's teams |
| `GET /api/me/websites` | User's websites (`includeTeams` param) |

## Teams Endpoints

| Endpoint | Purpose |
|----------|---------|
| `GET /api/teams` | List all teams |
| `POST /api/teams` | Create team (requires `name`) |
| `POST /api/teams/join` | Join via `accessCode` |
| `GET /api/teams/:id` | Get team |
| `POST /api/teams/:id` | Update team |
| `DELETE /api/teams/:id` | Delete team |
| `GET /api/teams/:id/users` | List members |
| `POST /api/teams/:id/users` | Add member |
| `GET /api/teams/:id/users/:userId` | Get member |
| `POST /api/teams/:id/users/:userId` | Update role |
| `DELETE /api/teams/:id/users/:userId` | Remove member |
| `GET /api/teams/:id/websites` | List team websites |

### Roles
- `team-member` — Standard access
- `team-view-only` — Read-only access
- `team-manager` — Management permissions

## Users Endpoints (Self-hosted admin only)

| Endpoint | Purpose |
|----------|---------|
| `POST /api/users` | Create user (`username`, `password`, `role` required) |
| `GET /api/users/:id` | Get user |
| `POST /api/users/:id` | Update user |
| `DELETE /api/users/:id` | Delete user |
| `GET /api/users/:id/websites` | User's websites |
| `GET /api/users/:id/teams` | User's teams |

### User Roles
- `admin` — Full system access
- `user` — Standard access
- `view-only` — Read-only access

**Note:** Users API endpoints are only available for self-hosted instances for admin users, not Umami Cloud.
