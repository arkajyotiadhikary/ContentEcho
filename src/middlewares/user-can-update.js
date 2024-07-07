"use strict";
const _ = require("lodash");

/**
 * `user-find-many` middleware
 */

module.exports = (config, { strapi }) => {
  // Add your own logic here.
  return async (ctx, next) => {
    strapi.log.info("In user-can-update middleware.");

    if (!ctx.state?.user) {
      strapi.log.error("No user found in context. Aborting.");
      return ctx.badRequest("No user found in context. Aborting.");
    }

    const params = ctx.params;
    const requestedUserID = params?.id;
    const currentUserID = ctx.state.user?.id;

    if (!requestedUserID) {
      strapi.log.error("No user found in context. Aborting.");
      return ctx.badRequest("No user found in context. Aborting.");
    }
    if (Number(currentUserID) !== Number(requestedUserID)) {
      return ctx.unauthorized("You are not allowed to update this user.");
    }
    await next();
  };
};
