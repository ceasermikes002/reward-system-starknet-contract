%lang starknet

@storage_var
func user_points(user: felt252) -> (points: felt252):
end

@event
func PointsAdded(user: felt252, points: felt252):
end

@event
func PointsRedeemed(user: felt252, points: felt252):
end

@constructor
func constructor():
    return ()
end

@external
func add_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*}(user: felt252, points: felt252):
    assert_nn(points)
    let (current_points) = user_points.read(user)
    user_points.write(user, current_points + points)
    PointsAdded.emit(user, points)
    return ()
end

@external
func redeem_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*}(user: felt252, points: felt252):
    assert_nn(points)
    let (current_points) = user_points.read(user)
    assert current_points >= points, "Insufficient points"
    user_points.write(user, current_points - points)
    PointsRedeemed.emit(user, points)
    return ()
end

@view
func get_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*}(user: felt252) -> (points: felt252):
    let (points) = user_points.read(user)
    return (points)
end
