### NEXT
- [ ] **Milestone 5 — Automatic token refresh**
- Interceptor that detects 401 and calls POST /auth/refresh automatically
- Queue pending requests during refresh (no parallel refresh calls)
- Redirect to login if refresh fails

- [ ] **Milestone 6 — Links list** (AppView)
- Fetch and display user links (GET /links/me/links)
- Pull to refresh
- Swipe to delete (DELETE /links/:code)
- Dashboard row: total clicks + active links count (computed client-side)

- [ ] **Milestone 7 — Create link**
- URL input field
- Expiration picker: 7 days / 30 days / never
- POST /links/shorten

- [ ] **Milestone 8 — Link detail**
- Full stats (total clicks, created at, last visit)
- Copy short link button with animated checkmark feedback
- QR code generated via CoreImage (no external libraries)

- [ ] **Milestone 9 — Profile**
- Display user name and email
- Sign out button

- [ ] **Milestone 10 — Polish**
- Loading states on all async actions
- User-friendly error messages
- Animations
- App icon

### TODO
# Check if i'm following switch code patterns correctly
# Make variables and props names more clear
# Test form with keyboard visible
# Save token and use refresh token automatically
# Forgot password in Api
# Add Terms of use
# Apply Toast for global usage
# Create input component?
# Clean var names and english only