Factory.define :user do |user|
  user.firstname                    "George"
  user.lastname                     "Washington"
  user.username                     "george_washington"
  user.email                        "example@example.com"
  user.password                     "foobar"
  user.password_confirmation        "foobar"
end