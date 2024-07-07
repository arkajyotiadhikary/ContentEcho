// @ts-nocheck
"use strict";

module.exports = {
  /**
   * An asynchronous register function that runs before
   * your application is initialized.
   *
   * This gives you an opportunity to extend code.
   */ register(/*{ strapi }*/) {
    // Log the structure of the users-permissions plugin
    console.log(strapi.plugins["users-permissions"]);

    // Getting all the users permissions routes
    const userRoutes = strapi.plugins["users-permissions"].config.routes;

    // Ensure routes is defined
    if (!userRoutes) {
      console.error("Users permissions routes are not defined");
      return;
    }

    // Set the UUID for our middleware
    const isUserOwnerMiddleware = "global::user-find-many";
    const isUserCanUpdateMiddleware = "global::user-can-update";

    // Find the route where we want to add the middleware
    const findUserRoute = userRoutes.find(
      (route) => route.handler === "user.find" && route.method === "GET"
    );
     const findUserCanUpdateRoute = userRoutes.find(
      (route) => route.handler === "user.update" && route.method === "PUT"
    );

    // Add the middleware to the found route
    if (findUserRoute) {
      findUserRoute.config.middlewares.unshift(isUserOwnerMiddleware);
    }
    if (findUserCanUpdateRoute) {
      findUserCanUpdateRoute.config.middlewares.unshift(
        isUserCanUpdateMiddleware
      );
    }
  },

  /**
   * An asynchronous bootstrap function that runs before
   * your application gets started.
   *
   * This gives you an opportunity to set up your data model,
   * run jobs, or perform some special logic.
   */
  bootstrap(/*{ strapi }*/) {},
};
