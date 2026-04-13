import { BuildInfo } from 'capacitor-plugin-buildinfo';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    BuildInfo.echo({ value: inputValue })
}
