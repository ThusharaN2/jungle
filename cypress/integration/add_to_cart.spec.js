describe("add_to_cart.spec.js", () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("makes sure the total amount in cart after clicking add to cart button", () => {
    cy.get("li.nav-item.end-0").should("include.text", "My Cart(0)");

    cy.contains("button", "Add").first().click({ force: true });

    cy.get("li.nav-item.end-0").should("include.text", "My Cart(1)");
  });
}); 