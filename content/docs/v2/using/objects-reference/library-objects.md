---
toc: true
next: /using/policy-examples
prev: /using/objects-reference/logger-object
icon: "-&nbsp;"
title: Library Objects
weight: 245
---

Library of utility functions. (**v2.2**)
It exposes two static methods `SendMail` and `GetEmailAddress`.

## GetEmailAddress
Retrieve the email address for a user.

> Caveat: **This method works only in the Server Plugin**

You can use the DOMAIN\user form,
```
string email = Library.GetEmailAddress("WIN-3H7CMUV7KDM\\User1", "does-not-exists@example.com");
```

or the User Display name.
```
string email = Library.GetEmailAddress("User One", "does-not-exists@example.com");
```

## SendMail
Send an email using TFS current configuration.

> Caveat: **This method works only in the Server Plugin**

```
string to = "test@example.com";
string subject = "Sent from a Rule";
string body = "It worked!";
Library.SendMail(to, subject, body);
```

The `From` address is configured in TFS and cannot be changed.
