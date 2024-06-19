%lang starknet

@contract_interface
namespace IDonationStorage {
    func add_donation(donor: felt, amount: felt, timestamp: felt) -> ():
    end

    func get_donation_count() -> (count: felt):
    end

    func get_donation(index: felt) -> (donor: felt, amount: felt, timestamp: felt):
    end
}

@external
func __default__() -> () {
    return ();
}

@storage_var
func donation_storage_address() -> (address: felt):
end

@event
func DonationReceived(donor: felt, amount: felt, timestamp: felt) {
}

@constructor
func constructor(storage_address: felt) {
    donation_storage_address.write(storage_address);
    return ();
}

@external
func donate() {
    let (donor) = get_caller_address();
    let (amount) = get_contract_balance();
    let timestamp = get_block_timestamp();

    let (storage_address) = donation_storage_address.read();
    IDonationStorage(storage_address).add_donation(donor, amount, timestamp);

    emit DonationReceived(donor, amount, timestamp);

    return ();
}

@view
@external
func get_donation_count() -> (count: felt) {
    let (storage_address) = donation_storage_address.read();
    let (count) = IDonationStorage(storage_address).get_donation_count();
    return (count,);
}

@view
@external
func get_donation(index: felt) -> (donor: felt, amount: felt, timestamp: felt) {
    let (storage_address) = donation_storage_address.read();
    let (donation) = IDonationStorage(storage_address).get_donation(index);
    return (donation.donor, donation.amount, donation.timestamp);
}
