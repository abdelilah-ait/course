require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
 	 FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without a email" do
  	FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "is invalid without a password" do
  	FactoryGirl.build(:user, password: nil).should_not be_valid
  end

  it "returns a user's email and password as a string" do
  	user = FactoryGirl.create(:user, email: "abdou@ex.com", password: "me", password_confirmation: "me")
  	user.info.should == "abdou@ex.com ----> me"
  end
  
  describe "filter name by letter" do
  	before :each do 
  		@abdelilah = FactoryGirl.create(:user, name: "abdelilah")
	  	@abdelkarim = FactoryGirl.create(:user, name: "abdelkarim")
	  	@marouane = FactoryGirl.create(:user, name: "marouane")
	  	@hassanaami = FactoryGirl.create(:user, name: "hassanaami")
	  	@hassankhali = FactoryGirl.create(:user, name: "hassankhali")
    end


    context "matching letters" do
	  	it "returns a sorted array of results that match" do
		  	User.by_letter("a").should == [@abdelilah, @abdelkarim, @hassanaami, @hassankhali, @marouane]
		  	User.by_letter("h").should == [@abdelilah, @hassanaami, @hassankhali] 
		  	User.by_letter("m").should == [@abdelkarim, @hassanaami, @marouane]
	 	end
	end


    context "non-matching letters" do
	  	it "does not return users that don't exists the provided letter" do
		  	User.by_letter("a").should_not include nil
		  	User.by_letter("h").should_not include @abdelkarim, @marouane 
		  	User.by_letter("m").should_not include @abdelilah, @hassankhali
	 	  end
	  end
  end

  it {should have_many(:phones)}
  it {should have_many(:orders)}
end
