RSpec.describe StephanyCryptodemo do

  before(:each) do
    @blockchain = StephanyCryptodemo::Blockchain.new
  end

  it "has a version number" do
    expect(StephanyCryptodemo::VERSION).not_to be nil
  end

  it "initialize method pushes a new block into the blockchain" do
    expect(@blockchain.chain.length).to eq(1)
  end

  it "initialize method returns a valid block" do
    block_to_check = @blockchain.last_block

    expect(block_to_check[:index]).not_to be nil
    expect(block_to_check[:index]).to eq(1)

    expect(block_to_check[:timestamp]).not_to be nil

    expect(block_to_check[:transactions]).not_to be nil
    expect(block_to_check[:transactions]).to eq([])

    expect(block_to_check[:proof]).not_to be nil
    expect(block_to_check[:proof]).to eq(100)

    expect(block_to_check[:previous_hash]).not_to be nil
    expect(block_to_check[:previous_hash]).to eq(1)

  end


  it "proof_of_work returns an integer value" do
    last_block = @blockchain.last_block
    proof = @blockchain.proof_of_work(last_block[:proof])
    expect(proof).to be_a_kind_of(Integer)
  end

  it "proof_of_work returns a value that concatenated with previous_proof should get a hash with an '0000' ending" do
    last_block = @blockchain.last_block
    previous_proof = last_block[:proof]
    proof = @blockchain.proof_of_work(previous_proof)

    concatenated_value = "#{previous_proof}#{proof}"
    expect(Digest::SHA256.hexdigest(concatenated_value)[-4..-1]).to eq('0000')
  end


  it "new_transaction adds a new transaction & the index of the last block on the blockchain list" do
    last_block = @blockchain.last_block

    expect(last_block).not_to be nil

    last_block_index = @blockchain.new_transaction('StephanyCryptodemo', 'Stephany', 1)
    expect(last_block_index).to eq(0)
  end

  it "new_transaction is going to be attached to a new block" do
    last_block = @blockchain.last_block
    previous_proof = last_block[:proof]
    proof = @blockchain.proof_of_work(previous_proof)

    sender = 'StephanyCryptodemo'
    recipient = 'Stephany'
    amount_to_transfer = 1
    last_block_index = @blockchain.new_transaction(sender, recipient, amount_to_transfer)


    previous_block_hash = @blockchain.hash(last_block)
    new_block = @blockchain.new_block(proof, previous_block_hash)
    added_transaction = new_block[:transactions][0]

    puts "new_block: #{new_block} \nTransactions #{added_transaction}"

    expect(new_block[:index]).to be > last_block_index
    expect(new_block[:proof]).to eq(proof)
    expect(new_block[:previous_hash]).to eq(previous_block_hash)

    expect(added_transaction[:sender]).to eq(sender)
    expect(added_transaction[:recipient]).to eq(recipient)
    expect(added_transaction[:amount]).to eq(amount_to_transfer)

  end

end
