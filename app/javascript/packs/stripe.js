import '@stripe/stripe-js';

document.querySelector("#stripe").addEventListener("click", () => {
  const id = location.pathname.split("/")[2]
  fetch(`/payments?id=${id}`, {
    method: "POST",
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then((res) => {
    return res.json()
  })
  .then((data) => {
    console.log(data)
    const stripe = Stripe("pk_test_51HnYEwL4EsoGPzpByD4Vdoi0VeHOhl5lIqClUMPAfcKMXDOHxYtgdmujnOyfXHETmp0ZiqrCxeGTNaaSdT3MWIv100RURRTqfV");
    stripe.redirectToCheckout({
      sessionId: data.id
    });
  })
  .catch((err) => {
    console.log(err.message)
  })
});
