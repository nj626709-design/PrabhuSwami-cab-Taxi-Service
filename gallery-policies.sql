-- Replace the UUID below with the exact User ID from Supabase > Authentication > Users.
-- This removes the broad authenticated policies previously created.
drop policy if exists "Authenticated users can view gallery" on storage.objects;
drop policy if exists "Authenticated users can upload gallery" on storage.objects;
drop policy if exists "Authenticated users can delete gallery" on storage.objects;
drop policy if exists "Public can list gallery files" on storage.objects;
drop policy if exists "Client admin can upload gallery" on storage.objects;
drop policy if exists "Client admin can delete gallery" on storage.objects;

-- Allows visitors to list gallery objects so the public website can build its gallery.
create policy "Public can list gallery files"
on storage.objects for select to anon, authenticated
using (bucket_id = 'Gallery');

-- Only the designated client account can upload.
create policy "Client admin can upload gallery"
on storage.objects for insert to authenticated
with check (
  bucket_id = 'Gallery'
  and auth.uid() = 'REPLACE_WITH_CLIENT_USER_UUID'::uuid
);

-- Only the designated client account can delete.
create policy "Client admin can delete gallery"
on storage.objects for delete to authenticated
using (
  bucket_id = 'Gallery'
  and auth.uid() = 'REPLACE_WITH_CLIENT_USER_UUID'::uuid
);
