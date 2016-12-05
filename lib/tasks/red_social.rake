namespace :redsocial do
    desc "available on the database state facebook and twitter"

    task statefacebook: :environment do
        
        FEED_API_FIELDS = "message,story,picture,created_time"
        LIMIT = 5
       User.published.find_each do |user|

            @posts = user.facebook(user).get_connections('me', "feed?fields=#{FEED_API_FIELDS}&amp;limit=#{LIMIT}")
            

            @posts.first(6).reverse_each do |post|
                if   user.final_date.nil?
                    status = user.statuses.new(user_id: user.id, content: post["message"] , image: post["picture"])
                    status.save
                    user.update_attribute(:final_date, Time.parse(post['created_time']))

                elsif Time.parse(post['created_time']) > user.final_date
                    status = user.statuses.new(user_id: user.id, content: post["message"] , image: post["picture"])
                    status.save
                    user.update_attribute(:final_date, Time.parse(post['created_time']))
                end
                
            end
       end
    end

    task statetwitter: :environment do
        User.published_twitter.find_each do |user|
            @posts = user.twitter(user).user_timeline( user.profile_name, count: 10) 

            @posts.first(6).reverse_each do |post|

                if   user.final_date_twitter.nil?
                    status = user.statuses.new(user_id: user.id, content: post.text)
                    status.save
                    user.update_attribute(:final_date_twitter, post.created_at)

                elsif post.created_at > user.final_date_twitter
                    status = user.statuses.new(user_id: user.id, content: post.text)
                    status.save
                    user.update_attribute(:final_date_twitter, post.created_at)
                end
                                        
            end

        end
    end

end