require 'test_helper'

class ChefTest < ActiveSupport::TestCase

    def setup
        @chef = Chef.new(chefname: "mashrur", email: "mashrur@example.com", password: "password", password_confirmation: "password")
    end


    # 1. Use ActiveRecord assertion to check that the chef is valid:

    test "should be valid" do
        assert @chef.valid?
    end


    # 2. " " check that the chef name is present:

    test "name should be present" do
        @chef.chefname = " "
        assert_not @chef.valid?
    end


    # 3. " " check that the chef name is less than 30 characters:

    test "name should be less than 30 characters" do
        @chef.chefname = "a" * 31
        assert_not @chef.valid?
    end


    # 4. " " check that the email is present:

    test "email should be present" do
        @chef.email = " "
        assert_not @chef.valid?
    end


    # 5. " " check that the email isn't too long:

    test "email should not be too long" do
        @chef.email = "a" * 245 + "@example.com"
        assert_not @chef.valid?
    end


    # 6. " " check that the email accepts correct formats:

    test "email should accept correct format" do
        valid_emails = %w[user@example.com MASHRUR@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
        valid_emails.each do |valids|
            @chef.email = valids
            assert @chef.valid?, "#{valids.inspect} should be valid"
        end
    end


    # 7. " " check that the email rejects incorrect formats:

    test "email should reject invalid addresses" do
        invalid_emails = %w[mashrur@example mashrur@example,com mashrur.name@gmail. joe@bar+foo.com]
        invalid_emails.each do |invalids|
            @chef.email = invalids
            assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
        end
    end


    # 8. " " check that the email address is unique and case insensitive:

    test "email should unique and case insensitive" do
        duplicate_chef = @chef.dup
        duplicate_chef.email = @chef.email.upcase
        @chef.save
        assert_not duplicate_chef.valid?
    end


    # 9. " " check that email is lower case before hitting database:

    test "email should be lower case before hitting DB" do
        mixed_email = "jOhN@examPle.cOm"
        @chef.email = mixed_email
        @chef.save
        assert_equal mixed_email.downcase, @chef.reload.email
    end



    # 10. " " check that the password is present:

    test "password should be present" do
        @chef.password = @chef.password_confirmation = " "
        assert_not @chef.valid?
    end


    # 11. " " check that the password is at least 5 characters:

    test "password should be at least 5 characters" do
        @chef.password = @chef.password_confirmation = "x" * 4
        assert_not @chef.valid?
    end


    # 12. " " check that associated recipes are destroyed/deleted:

    test "associated recipes should be destroyed" do
        @chef.save
        @chef.recipes.create!(name: "testing delete", description: "testing delete function")
        assert_difference 'Recipe.count', -1 do
            @chef.destroy
        end
    end
    
end