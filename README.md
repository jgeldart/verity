# Verity: An elegant DSL for validations

Verity's aim is to make validations readable and composable and, therefore,
more maintainable. After spending too long writing complex, interdependent
validations for a project with an (admittedly) tricky data model, I decided
that enough was enough. Validations are a vital part of the definition of a
data model in any real-world application, where data noise can be introduced
by its users and must be prevented. As such, they should be as nice to define
as possible.

Verity accomplishes this in two main ways:

- It provides a DSL for defining the validations in a readable syntax similar
  to RSpec.
- It treats validations lazily, so that they can be composed to construct more
  complex validations out of simpler ones.

The main inspirations for the project are [RSpec][] and [Semantic Attributes][], 
a similar attempt to define a DSL for validations (although without the 
composability).

As additional goals, Verity aims to:

- Be agnostic as to what persistence framework, if any, is being used; it is 
  as useful on plain Ruby objects as it is on ActiveRecord records.
- Be easy to extend, with new predicates that can be shared with other
  developers and projects.
- Integrate well with whatever internationalisation framework is being used to
  support multi-lingual and multi-region applications.

Possible future goals include integration with YARD, for easy documentation of
model constraints, and RSpec and Cucumber, for testing these constraints. 

## Using Verity

Enabling Verity's DSL and core API on an object is simply a matter of using the 
class method `verifiable` in the class definition. This is an extension added
to `Object` when the gem is loaded:

    class User
      verifiable
    end

Instances of this class now have a number of methods defined upon them for
performing validations. `#valid?` returns `false` if and only if the 
instance fails to satisfy the defined conditions and `true` otherwise (note
that it will return `true` if no validations are defined at all).
`#validation_errors` returns a `Hash`, keyed by attribute name, of any errors
found on the instance. This allows you to report failures back to your users 
in a natural fashion.

Validations are defined using the syntax `attribute_name_must` (for
positive validations) or `attribute_name_must_not` (for negative ones).

These validations are built using *predicates*, objects that represent abstract 
tests against values. The simplest predicate is a nil check, which matches
values that are `nil`:

    class User
      verifiable

      attr_accessor :login
      login_must_not be_nil
    end

Multiple validations may be defined against an attribute and all will be tested:

    class User
      verifiable

      attr_accessor :login
      login_must_not be_nil
      login_must have_length(:at_least => 4)
    end

Predicates can take late-bound parameters, either positional or named:

    class User
      verifiable

      attr_accessor :login, :star_count
      login_must have_length, :at_least => 4
      star_count_must be_greater_than, 5
    end

Defining new predicates is as simple as defining a new class that inherits from
`Verity::Predicates::Base` and a class method (available to your class) that
constructs an appropriate instance of your class. Methods defined within
`Verity::Predicates` are automatically available to all classes which define
`verifiable`. As with RSpec, it is through judicious use of these methods that 
we gain our readability, so think carefully about how your definitions 'read'.
In particular, be sparing with positional parameters (and treat them like
direct and indirect objects in English) and use named parameters with keys that
read like prepositional phrases (such as `with_domain` or `at_least`).

## Lazy Parameters

Often we want to validate based on data only available at run-time, and often
specific to the record being validated. Named predicate parameters in Verity
support lazy evaluation using blocks. A block-valued parameter is evaluated at
validation time to produce a value, which is then set on that predicate. The
blocks may, optionally, take a parameter which is set to the record instance
being validated. This may be used to retrieve attribute values at run-time. 

    class Message
      verifiable

      attr_accessor :length, :message
      message_must have_length, :exactly => lambda{|r| r.length}
    end

In fact, this usage is so important that we have a sugar defined for it using
a method `the`:

    class Message
      verifiable

      attr_accessor :length, :message
      message_must have_length, :exactly => the(:length)
    end

It is planned to support this for positional parameters as well very shortly
but this hasn't been implemented yet.

[RSpec]: http://rspec.info/
[Semantic Attributes]: http://github.com/cainlevy/semantic-attributes/
