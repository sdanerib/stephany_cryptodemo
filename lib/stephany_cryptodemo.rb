require "stephany_cryptodemo/version"
require 'json'
require 'digest'

module StephanyCryptodemo

 class Blockchain

   attr_reader :chain

   def initialize
     @chain = []
     @current_transactions = []

     # Generating First Block of Blockchain (the first block is called 'Genesis Block')
     new_block(100, 1)
   end

   def proof_of_work(last_proof)
     # Piece of data hard to generate but easy to validate
     # Generate it, could take some time (X hours to generate a new block)
     # It allow us to validate if the person using this gem is actually spending time to mining a new block

     # It will calculate a number that concatenated to the last_proof
     # will return a hash with 4 zeros at the end
     # Ex:
     # efc26373838..0000

     proof = 0

     while !Blockchain.valid_proof(last_proof, proof) do
       proof += 1
     end

     proof

   end


   def new_block(proof_of_work, previous_hash = nil)
     # To generate a new block, we need:
     # - proof of work
     # - the previous hash to control the blocks chain creation

     previous_hash ||= self.hash(@chain[-1])

     block = {

         :index => @chain.count + 1,
         :timestamp => Time.now.to_i,
         :transactions => @current_transactions,
         :proof => proof_of_work,
         :previous_hash => previous_hash,
     }

     # The chain must restart the transactions being stored
     # to store the transactions coming for the new block
     @current_transactions = []
     @chain.push(block)
     block
   end


   def new_transaction(sender, recipient, amount)
     # Just like a Bank Transaction
     # You need a sender, a recipient and the amount to transfer

     transaction = {
         :sender => sender,
         :recipient => recipient,
         :amount => amount
     }

     @current_transactions.push(transaction)

     @chain.index(last_block)

   end


   def last_block
    @chain[-1]
   end


   def hash(block)
     # If we need to create a hash for the block
     Blockchain.hash(block)
   end


   def self.hash(block)
    block_string = block.to_json

    # return SHA256 for the given block
    Digest::SHA256.hexdigest(block_string)

   end


   def self.valid_proof(last_proof, new_proof)

     # return true if the resulting hash has 4 zeros at the end
     guess = "#{last_proof}#{new_proof}"
     guess_hash = Digest::SHA256.hexdigest(guess)

     guess_hash.to_s[-4..-1] == '0000'

   end


 end

end
