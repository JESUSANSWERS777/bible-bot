require File.expand_path '../spec_helper.rb', __FILE__

describe "Bible Bot for Slack" do
  let(:url) { '/bible' }

  it "should not respond to a default route" do
    get '/'
    expect(last_response).not_to be_ok
  end

  it "should respond to /bible" do
    post url, {
      :user_name => "thom",
      :trigger_word => "gospel",
      :text => "gospel John 3:16"
    }
    expect(last_response).to be_ok
  end

  it "should provide a single verse" do
    post url, { :text => "bible John 3:16", :trigger_word => "bible"}
    response = JSON.parse(last_response.body)
    expect(response["text"]).to include("so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.")
  end
  
  it "should respond to a key phrase" do
    post url, { :text => "bible work", :trigger_word => "bible"}
    response = JSON.parse(last_response.body)
    expect(response["text"]).to satisfy do |t|
       t.match(/Timothy 5:8/)|| t.match(/Proverbs 13:4/)|| t.match(/Proverbs 14:23/)|| t.match(/Proverbs 12:24/)|| t.match(/Proverbs 16:3/)|| t.match(/Proverbs 12:11/)|| t.match(/Proverbs 6:10/)|| t.match(/Genesis 2:15/)|| t.match(/Philippians 4:13/)|| t.match(/2 Timothy 2:6/)|| t.match(/Titus 2:7/)|| t.match(/Luke 1:37/)|| t.match(/Jeremiah 29:11/)|| t.match(/Colossians 3:2[3|4]/)|| t.match(/Psalms 90:17/)
    end
  end
end
