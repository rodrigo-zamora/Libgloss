var List = dynogels.define('List', {
    hashKey : 'UUID',
    schema : {
        UUID            : dynogels.types.uuid(),
        // que sea una lista de TrackingListItem
        Tracking        : dynogels.types.stringSet(),
        // que sea una lista de WishListItem
        Wish            : dynogels.types.stringSet(),
    }
});