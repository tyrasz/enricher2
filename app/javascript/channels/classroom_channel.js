import consumer from "./consumer";

const initClassroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.classroomId;

    consumer.subscriptions.create({ channel: "ClassroomChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        messagesContainer.querySelector('.list-unstyled')insertAdjacentHTML('beforeend', data);
      },
    });
  }
}

export { initClassroomCable };
