var Users = dynogels.define('Users', {
    hashKey : 'UUID',
    timestamps : true,
    schema : {
        UUID            : dynogels.types.uuid(),
        email           : Joi.string().email(),
        isAdministrator : Joi.binary(),
        sellerUUID      : dynogels.types.uuid(),
        notifications   : Joi.binary(),
        phoneNumber     : Joi.string(),
        profilePicture  : Joi.string(),
        token           : Joi.string(),
        username        : Joi.string(),
        zipCode         : Joi.string(),
    }
});