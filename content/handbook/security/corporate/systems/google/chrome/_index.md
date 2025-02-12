# Duplicate Chrome Profile Created

This guide to help team members who had an extra Google Chrome profile created and they end up losing all their bookmarks.

## Steps

**READ ME:** Read all the steps below running through the steps, we cannot recover a deleted Chrome profile if you delete the wrong one. 

### Deleting the newly created profile 

1. Open Chrome.
2. Click your profile picture in Chrome → `Manage Chrome Profiles`.
3. To figure out which Chrome profile is the correct one to delete.

    Based on the screenshots below, I would be deleting `new-profile` as it has a low count of bookmarks, browsing history, etc.:
    - Click on the ⋮ (triple dots) → delete → in a pop-up it'll show a low bookmarks/browsing history count.
    ![alt text](/static/images/security/corporate/systems/google/chrome/image-1.png)
    ![alt text](/static/images/security/corporate/systems/google/chrome/image-2.png)
    ![alt text](/static/images/security/corporate/systems/google/chrome/image-3.png)

### Loading the correct profile

1. Open the old profile that has all your bookmarks/browsing history, etc. Based on the example above it would be `old-profile`. 
2. When you get the `Your organization requires a profile` , make sure the `Add existing browsing data to managed profile` box is checked off.

    ![alt text](/static/images/security/corporate/systems/google/chrome/image-4.png)

3. When prompted to `Turn on Sync`, click `Yes, I'm in`. This will back up your bookmarks, browsing history, etc. into your work Google account.

    ![alt text](/static/images/security/corporate/systems/google/chrome/image-5.png)
4. Your bookmarks, browsing history, etc. should now be restored.