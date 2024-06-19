# Contract code for DonationStorage

@contract_interface
namespace DonationStorageInterface:
    func store_donation(donor: felt, amount: felt, timestamp: felt):
    end

    func get_donation(index: felt) -> (donor: felt, amount: felt, timestamp: felt):
    end

    func get_donation_count() -> (count: felt):
    end
end

@storage_var
func donations(index: felt) -> (donor: felt, amount: felt, timestamp: felt):
end

@storage_var
func donation_count() -> (count: felt):
end

@external
func store_donation(donor: felt, amount: felt, timestamp: felt):
    let (count) = donation_count.read()
    donations.write(count, (donor, amount, timestamp))
    donation_count.write(count + 1)
    return ()
end

@external
func get_donation(index: felt) -> (donor: felt, amount: felt, timestamp: felt):
    let (donor, amount, timestamp) = donations.read(index)
    return (donor, amount, timestamp)
end

@external
func get_donation_count() -> (count: felt):
    let (count) = donation_count.read()
    return (count)
end
