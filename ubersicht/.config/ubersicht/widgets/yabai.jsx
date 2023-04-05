/**
 * Resize the Dock with:
 * defaults write com.apple.Dock tilesize -float 40; killall Dock
 */

// @ts-ignore
import { styled, css, run } from "uebersicht";

export const command = "/opt/homebrew/bin/yabai -m query --spaces";

const Spaces = styled("div")`
  display: flex;
  flex-direction: row;
  background: rgba(255, 255, 255, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  justify-content: center;
  box-shadow: 0px 0px 12px rgba(0, 0, 0, 0.3);
  overflow: hidden;
`;

const Space = styled("div")`
  height: 40px;
  width: 50px;
  background: ${(props) => (props.active ? "rgba(255, 255, 255, 0.3)" : "")};
  line-height: 40px;
  cursor: pointer;
  text-align: center;
  marginright: 5px;
`;

export const initialState = { output: "[]" };

export const render = ({ output }, dispatch) => {
  let spaces = [];
  try {
    spaces = JSON.parse(output);
  } catch (error) {}

  return (
    <div>
      <Spaces>
        {spaces.map((space, idx) => (
          <Space
            key={idx}
            active={space.focused == 1}
            empty={space.windows.length == 0}
            onClick={() => {
              spaces[idx].focused = 1;
              dispatch({
                type: "OUTPUT_UPDATED",
                output: JSON.stringify(
                  spaces.map((s, i) => {
                    s.focused = i == idx;
                    return s;
                  })
                ),
              });
              run(`/opt/homebrew/bin/yabai -m space --focus ${space.index}`);
            }}
          >
            {space.windows.length ? "" : ""}
          </Space>
        ))}
      </Spaces>
    </div>
  );
};

export const className = {
  top: 0,
  cursor: "pointer",
  left: 50,
  color: "#fff",
  "font-size": "24px",
  "font-family": "'JetBrainsMono Nerd Font Mono'",
  "font-style": "Light",
};

export const refreshFrequency = 600 * 1000;
