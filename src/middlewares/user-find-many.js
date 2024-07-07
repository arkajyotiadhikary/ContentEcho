"use strict";

/**
 * `user-find-many` middleware
 */

module.exports = (config, { strapi }) => {
  // Add your own logic here.
  return async (ctx, next) => {
    strapi.log.info("In user-find-many middleware.");
    const currentUserID = ctx.state.user?.id;
    if (!currentUserID) {
      strapi.log.error("No user found in context. Aborting.");
      return ctx.badRequest("No user found in context. Aborting.");
    }
    ctx.query = {
      ...ctx.query,
      filters: { ...ctx.query.filters, user: { id: { $eq: currentUserID } } },
    };
    await next();
  };
};
