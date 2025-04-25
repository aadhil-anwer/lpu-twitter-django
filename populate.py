import os
import random
from django.core.files import File
from django.contrib.auth.models import User
from user.models import Profile  # replace 'user' with your actual app name

# Adjust if your images are in a different place
image_paths = [f'media/profile_pics/{i}.jpg' for i in range(1, 5)]

for user in User.objects.all():
    profile, created = Profile.objects.get_or_create(user=user)
    image_path = random.choice(image_paths)
    with open(image_path, 'rb') as img_file:
        profile.image.save(f'{user.username}.jpg', File(img_file), save=True)
    print(f"{user.username} → {profile.image.url}")
