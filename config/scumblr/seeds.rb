
admin_user = "admin@admin.admin"
admin_password = "password"

if(ENV["SCUMBLR_ADMIN_USER"])
  admin_user = ENV["SCUMBLR_ADMIN_USER"]
end
if(ENV["SCUMBLR_ADMIN_PASSWORD"])
  admin_password = ENV["SCUMBLR_ADMIN_PASSWORD"]
end

if(ENV["SCUMBLR_SEED_ADMIN"] == "true" && User.count == 0)
  User.create(:email=>admin_user, :password=>admin_password,
              :password_confirmation=>admin_password, :admin=>true)
end

if(ENV["SCUMBLR_SEED_STATUSES"] == "true" && Status.count == 0)
  Status.create(:name=>"New", :closed=>false, :is_invalid=>false)
  Status.create(:name=>"Investigating", :closed=>false, :is_invalid=>false)
  Status.create(:name=>"False Positive", :closed=>true, :is_invalid=>true)
  Status.create(:name=>"Closed", :closed=>true, :is_invalid=>false)
end
